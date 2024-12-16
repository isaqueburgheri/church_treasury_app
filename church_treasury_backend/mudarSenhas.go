package mudarSenhas

import (
	"fmt"

	"golang.org/x/crypto/bcrypt"
)

func mudarSenhas() {
	password := "1234" // Sua nova senha
	hash, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		fmt.Println("Erro ao gerar hash:", err)
		return
	}
	fmt.Println("Novo hash gerado:", string(hash))
}
