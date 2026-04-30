-- name: InsertResult :one
-- Inserta el resultado del procesamiento.
-- El id es SERIAL → la BD garantiza atomicidad del autoincremental
-- aunque varios workers inserten al mismo tiempo.
INSERT INTO result (input_id, worker_identifier, result)
VALUES ($1, $2, $3)
RETURNING *;

-- name: GetResultsByWorker :many
-- Cuántas tareas procesó cada worker.
SELECT worker_identifier, COUNT(*) AS tareas
FROM result
GROUP BY worker_identifier
ORDER BY worker_identifier;

-- name: GetDuplicateInputs :many
-- Verificación de integridad: NO debe devolver filas.
-- Si devuelve algo, hubo un fallo en el control de concurrencia.
SELECT input_id, COUNT(*) AS veces_procesada
FROM result
GROUP BY input_id
HAVING COUNT(*) > 1;