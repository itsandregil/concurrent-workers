package main

import (
	"database/sql"
	"fmt"
	"log"

	"github.com/itsandregil/concurrent-workers/internal/config"
	_ "github.com/lib/pq"
)

func main() {
	cfg := config.NewConfig()

	db, err := sql.Open("postgres", cfg.DBUrl)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	if err := db.Ping(); err != nil {
		log.Fatal(err)
	}
	fmt.Println("Connected to the database")
}
