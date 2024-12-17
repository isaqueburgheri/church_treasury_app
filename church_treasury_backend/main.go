package main

// Importação dos pacotes necessários
import (
	"database/sql" // Para interagir com o banco de dados
	"fmt"          // Para formatação de saída
	"log"          // Para registro de logs de erro
	"net/http"     // Para manipulação de requests HTTP
	"os"
	"time" // Para manipulação de data e hora

	"github.com/dgrijalva/jwt-go" // Biblioteca para criar e validar JWTs
	"github.com/gin-gonic/gin"    // Framework web para o desenvolvimento da API
	_ "github.com/lib/pq"         // Driver do PostgreSQL
)

// Chave secreta para assinatura dos tokens JWT
var jwtKey = []byte("1234")

// Estrutura de dados que representa um usuário
type User struct {
	Username string `json:"username"` // Nome de usuário
	Password string `json:"password"` // Senha do usuário
	Role     string `json:"role"`     // Role do usuário (admin ou user)
}

// Estrutura de dados que representa as claims (informações) do token JWT
type Claims struct {
	Username           string `json:"username"` // Nome de usuário
	Role               string `json:"role"`     // Role do usuário
	jwt.StandardClaims        // Dados padrões do JWT, como data de expiração
}

var db *sql.DB // Declaração do objeto db para conexão com o banco de dados

// Função para conectar ao banco de dados PostgreSQL
func connectToDB() {
	var err error
	// Usa a variável de ambiente DATABASE_URL, se definida, ou um valor padrão
	connStr := os.Getenv("DATABASE_URL")
	if connStr == "" {
		log.Fatal("A variável de ambiente DATABASE_URL não foi configurada")
	}

	db, err = sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal("Erro ao conectar ao banco de dados: ", err)
	}

	// Testa a conexão
	err = db.Ping()
	if err != nil {
		log.Fatal("Erro ao conectar ao banco de dados: ", err)
	}
	fmt.Println("Conectado ao banco de dados!")
}

// Função principal que inicializa o servidor web e as rotas
func main() {
	// Conecta ao banco de dados
	connectToDB()
	defer db.Close() // Garante que a conexão será fechada ao finalizar a execução

	// Cria um novo roteador Gin
	r := gin.Default()

	// Define a rota de login (POST /login)
	r.POST("/login", func(c *gin.Context) {
		var user User // Cria um objeto User para armazenar os dados recebidos

		// Tenta fazer o parse do corpo da requisição para preencher o objeto user
		if err := c.ShouldBindJSON(&user); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Dados inválidos"}) // Se falhar, retorna erro de dados inválidos
			return
		}

		// Faz uma consulta ao banco de dados para obter o usuário, senha e role
		var dbUser User
		err := db.QueryRow("SELECT username, password, role FROM users WHERE username = $1", user.Username).Scan(&dbUser.Username, &dbUser.Password, &dbUser.Role)
		if err != nil {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Credenciais inválidas"}) // Se não encontrar o usuário, retorna erro de credenciais inválidas
			return
		}

		// Verifica se a senha fornecida corresponde à senha no banco de dados
		if dbUser.Password != user.Password {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Credenciais inválidas"}) // Se a senha for diferente, retorna erro
			return
		}

		// Se as credenciais estiverem corretas, gera um token JWT
		expirationTime := time.Now().Add(24 * time.Hour) // Define o tempo de expiração do token (24 horas)
		claims := &Claims{
			Username: user.Username, // Armazena o nome de usuário nas claims
			Role:     dbUser.Role,   // Armazena a role do usuário nas claims
			StandardClaims: jwt.StandardClaims{
				ExpiresAt: expirationTime.Unix(), // Define a data de expiração no formato Unix
			},
		}

		// Cria um novo token com as claims e a chave secreta
		token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
		tokenString, err := token.SignedString(jwtKey) // Assina o token com a chave secreta
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Erro ao gerar token"}) // Se falhar ao gerar o token, retorna erro
			return
		}

		// Retorna o token gerado como resposta
		c.JSON(http.StatusOK, gin.H{"token": tokenString})
	})

	// Inicia o servidor web na porta 8080
	// r.Run(":8080") // porta fixa

	// Inicia o servidor web na porta fornecida pela plataforma
	r.Run(":" + os.Getenv("PORT"))

}
