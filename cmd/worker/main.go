package main

import (
	"context"
	"database/sql"
	"fmt"
	"log"

	"github.com/itsandregil/concurrent-workers/internal/config"
	"github.com/itsandregil/concurrent-workers/internal/database"
	_ "github.com/lib/pq"
)

func main() {
	cfg := config.NewConfig()

	db, err := sql.Open("postgres", cfg.DBUrl)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	dbQueries := database.New(db)

	if err := db.Ping(); err != nil {
		log.Fatal(err)
	}
	fmt.Println("Connected to the database")

	err = dbQueries.CreateInput(context.Background(), "Hola Mundo")
	if err != nil {
		log.Fatal(err)
	}
}
