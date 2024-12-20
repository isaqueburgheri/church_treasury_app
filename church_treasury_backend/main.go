package main

// Importação dos pacotes necessários
import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"
	"time"

	"github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
	_ "github.com/lib/pq"
)

// Chave secreta para assinatura dos tokens JWT
var jwtKey = []byte("1234")

// Estrutura de dados que representa um usuário
type User struct {
	Username string `json:"username"`
	Password string `json:"password"`
	Role     string `json:"role"`
}

// Estrutura de dados que representa as claims (informações) do token JWT
type Claims struct {
	Username string `json:"username"`
	Role     string `json:"role"`
	jwt.StandardClaims
}

var db *sql.DB

// Estrutura para representar as mensagens
type Mensagem struct {
	ID          int       `json:"id"`
	Nome        string    `json:"nome"`
	Congregacao *string   `json:"congregacao"` // Campo opcional
	Mensagem    string    `json:"mensagem"`
	AnexoURL    *string   `json:"anexo_url"` // Campo opcional
	CreatedAt   time.Time `json:"created_at"`
}

// Função para conectar ao banco de dados PostgreSQL
func connectToDB() {
	var err error
	connStr := os.Getenv("DATABASE_URL")
	if connStr == "" {
		log.Fatal("A variável de ambiente DATABASE_URL não foi configurada")
	}

	db, err = sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal("Erro ao conectar ao banco de dados: ", err)
	}

	err = db.Ping()
	if err != nil {
		log.Fatal("Erro ao conectar ao banco de dados: ", err)
	}
	fmt.Println("Conectado ao banco de dados!")
}

// Função para enviar o POST e manter o servidor ativo
func keepServerAlive() {
	for {
		time.Sleep(5 * time.Minute)
		resp, err := http.Post("https://church-treasury-app.onrender.com/login",
			"application/json",
			strings.NewReader(`{"username": "rocky", "password": "balboa"}`))
		if err != nil {
			log.Println("Erro ao enviar POST:", err)
			continue
		}
		defer resp.Body.Close()
		log.Println("Requisição POST enviada com sucesso, status:", resp.Status)
	}
}

// Handler para buscar mensagens
func getMensagens(c *gin.Context) {
	rows, err := db.Query("SELECT id, nome, congregacao, mensagem, anexo_url, created_at FROM mensagens ORDER BY created_at DESC")
	if err != nil {
		log.Println("Erro ao buscar mensagens:", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Erro ao buscar mensagens"})
		return
	}
	defer rows.Close()

	var mensagens []Mensagem

	for rows.Next() {
		var mensagem Mensagem
		err := rows.Scan(&mensagem.ID, &mensagem.Nome, &mensagem.Congregacao, &mensagem.Mensagem, &mensagem.AnexoURL, &mensagem.CreatedAt)
		if err != nil {
			log.Println("Erro ao processar mensagem:", err)
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Erro ao processar mensagens"})
			return
		}
		mensagens = append(mensagens, mensagem)
	}

	c.JSON(http.StatusOK, mensagens)
}

// Função principal que inicializa o servidor web e as rotas
func main() {

	// Configura o Gin para o modo de produção (release mode)
	gin.SetMode(gin.ReleaseMode)

	connectToDB()
	defer db.Close()

	r := gin.Default()

	// Rota para login
	r.POST("/login", func(c *gin.Context) {
		var user User
		if err := c.ShouldBindJSON(&user); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Dados inválidos"})
			return
		}

		var dbUser User
		err := db.QueryRow("SELECT username, password, role FROM users WHERE username = $1", user.Username).Scan(&dbUser.Username, &dbUser.Password, &dbUser.Role)
		if err != nil {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Credenciais inválidas"})
			return
		}

		if dbUser.Password != user.Password {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Credenciais inválidas"})
			return
		}

		expirationTime := time.Now().Add(24 * time.Hour)
		claims := &Claims{
			Username: user.Username,
			Role:     dbUser.Role,
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

	// Nova rota para buscar mensagens
	r.GET("/api/mensagens", getMensagens)

	// Inicia o servidor web na porta fornecida pela plataforma
	r.Run(":" + os.Getenv("PORT"))
}
