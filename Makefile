postgres: 
	docker run --name postgres16 -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=St1990.pg -d postgres:16-alpine3.19

createdb:
	docker exec -it postgres16 createdb --username=postgres --owner=postgres simple_bank

dropdb:
	docker exec -it postgres16 dropdb simple_bank

migrateup: 
	migrate -path db/migration -database "postgresql://postgres:St1990.pg@127.0.0.1:5432/simple_bank?sslmode=disable" -verbose up

migratedown: 
	migrate -path db/migration -database "postgresql://postgres:St1990.pg@127.0.0.1:5432/simple_bank?sslmode=disable" -verbose down

sqlc: 
	sqlc generate

test: 
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test