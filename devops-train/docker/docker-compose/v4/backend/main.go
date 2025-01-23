package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"

	_ "github.com/lib/pq" // Импорт драйвера PostgreSQL
)

// User представляет структуру данных пользователя
type User struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

var db *sql.DB

// Функция для подключения к базе данных
func connectToDB() {
	var err error
	connStr := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable",
		os.Getenv("DB_HOST"),
		os.Getenv("DB_PORT"),
		os.Getenv("DB_USER"),
		os.Getenv("DB_PASSWORD"),
		os.Getenv("DB_NAME"),
	)
	fmt.Println(connStr)  // выводит пустые значения для отладки при сборке
	db, err = sql.Open("postgres", connStr)
	if err != nil {
		log.Fatalf("Ошибка подключения к базе данных: %v", err)
	}

	err = db.Ping()
	if err != nil {
		log.Fatalf("База данных недоступна: %v", err)
	}

	log.Println("Подключение к базе данных успешно установлено")
}

// Обработчик API для получения списка пользователей
func getUsersHandler(w http.ResponseWriter, r *http.Request) {
	rows, err := db.Query("SELECT id, name FROM users")
	if err != nil {
		http.Error(w, "Ошибка при запросе к базе данных", http.StatusInternalServerError)
		log.Printf("Ошибка выполнения запроса: %v", err)
		return
	}
	defer rows.Close()

	users := []User{}
	for rows.Next() {
		var user User
		if err := rows.Scan(&user.ID, &user.Name); err != nil {
			http.Error(w, "Ошибка при обработке данных", http.StatusInternalServerError)
			log.Printf("Ошибка сканирования строки: %v", err)
			return
		}
		users = append(users, user)
	}

	w.Header().Set("Content-Type", "application/json")
	if err := json.NewEncoder(w).Encode(users); err != nil {
		http.Error(w, "Ошибка при формировании ответа", http.StatusInternalServerError)
		log.Printf("Ошибка кодирования JSON: %v", err)
	}
}

// Точка входа в приложение
func main() {
	connectToDB()
	defer db.Close()

	http.HandleFunc("/api/users", getUsersHandler) // Регистрация маршрута API

	port := os.Getenv("BACKEND_PORT")
	if port == "" {
		port = "8080" // Значение по умолчанию
	}

	log.Printf("Сервер запущен на порту %s", port)
	if err := http.ListenAndServe(fmt.Sprintf(":%s", port), nil); err != nil {
		log.Fatalf("Ошибка запуска сервера: %v", err)
	}
}
