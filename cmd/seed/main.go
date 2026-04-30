package main

import (
	"context"
	"database/sql"
	"log"

	"github.com/go-faker/faker/v4"
	"github.com/itsandregil/concurrent-workers/internal/config"
	"github.com/itsandregil/concurrent-workers/internal/database"
	_ "github.com/lib/pq"
)

func main() {
	cfg := config.NewConfig()

	conn, err := sql.Open("postgres", cfg.DBUrl)
	if err != nil {
		log.Fatal(err)
	}
	defer conn.Close()

	seed(conn, 1000)
}

func seed(db *sql.DB, num_inputs int) {
	ctx := context.Background()
	dbQueries := database.New(db)

	for i := 0; i < num_inputs; i++ {
		err := dbQueries.CreateInput(ctx, faker.Sentence())
		if err != nil {
			log.Fatalf("failed to create input: %v", err)
			continue
		}
	}
}
