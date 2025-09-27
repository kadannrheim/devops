package main

import (
  "fmt"
  "net/http"
  "strconv"

  "github.com/go-redis/redis"
)

var client *redis.Client

func init() {
  client = redis.NewClient(&redis.Options{
    Addr:     "golang-redis-app-master:6379",
    Password: "",
    DB:       0,
  })
}

func visitCounter(w http.ResponseWriter, r *http.Request) {
  key := "page:viewcount"
  val, err := client.Incr(key).Result()
  if err != nil {
    http.Error(w, "Ошибка сервера", http.StatusInternalServerError)
    return
  }

  fmt.Fprintf(w, "Количество посещений: %s", strconv.FormatInt(val, 10))
}

func main() {
  http.HandleFunc("/", visitCounter)
  http.ListenAndServe(":8080", nil)
}