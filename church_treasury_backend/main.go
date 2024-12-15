package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
	_ "github.com/lib/pq"
)

// Chave secreta para assinatura dos tokens
var jwtKey = []byte("1234")

// Estrutura para usuários
type User struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

// Estrutura do token JWT
type Claims struct {
	Username string `json:"username"`
	jwt.StandardClaims
}

var db *sql.DB

// Função para conectar ao banco de dados
func connectToDB() {
	var err error
	// Atualize com as configurações do seu banco de dados na nuvem
	connStr := "postgres://postgres:okul8HDCJOaVU2ys@immutably-democratic-moth.data-1.use1.tembo.io:5432/postgres?sslmode=require"
	db, err = sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal("Erro ao conectar ao banco de dados: ", err)
	}

	// Testando a conexão
	err = db.Ping()
	if err != nil {
		log.Fatal("Erro ao conectar ao banco de dados: ", err)
	}
	fmt.Println("Conectado ao banco de dados!")
}

func main() {
	// Conectar ao banco de dados
	connectToDB()
	defer db.Close()

	r := gin.Default()

	// Rota de login
	r.POST("/login", func(c *gin.Context) {
		var user User
		if err := c.ShouldBindJSON(&user); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Dados inválidos"})
			return
		}

		// Validação de usuário fictício (substituir por verificação no banco)
		var dbUser User
		err := db.QueryRow("SELECT username, password_hash FROM users WHERE username = $1", user.Username).Scan(&dbUser.Username, &dbUser.Password)
		if err != nil {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Credenciais inválidas"})
			return
		}

		// Aqui você pode comparar a senha (se necessário, usar bcrypt)
		if dbUser.Password != user.Password {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Credenciais inválidas"})
			return
		}

		// Gerar token JWT
		expirationTime := time.Now().Add(24 * time.Hour)
		claims := &Claims{
			Username: user.Username,
			StandardClaims: jwt.StandardClaims{
				ExpiresAt: expirationTime.Unix(),
			},
		}
		token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
		tokenString, err := token.SignedString(jwtKey)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Erro ao gerar token"})
			return
		}

		c.JSON(http.StatusOK, gin.H{"token": tokenString})
	})

	// Iniciar o servidor na porta 8080
	r.Run(":8080")
}
