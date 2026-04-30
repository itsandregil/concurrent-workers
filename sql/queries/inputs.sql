-- name: GetPendingInputForUpdate :one
-- Toma UNA tarea pendiente y la bloquea para esta transacción.
-- SKIP LOCKED hace que otros workers salten esta fila si ya está bloqueada.
-- Esta es la query crítica para evitar condiciones de carrera.
SELECT id, description, status
FROM input
WHERE status = 'pending'
ORDER BY id
LIMIT 1
FOR UPDATE SKIP LOCKED;

-- name: MarkInputInProcess :exec
-- Marca una tarea como "en proceso" dentro de la misma transacción
-- que la tomó (mientras el lock FOR UPDATE sigue vigente).
UPDATE input
SET status = 'in_process'
WHERE id = $1;

-- name: MarkInputProcessed :exec
-- Marca una tarea como "procesada" al finalizar el trabajo.
UPDATE input
SET status = 'processed'
WHERE id = $1;

-- name: CountPendingInputs :one
-- para queel worker sepa cuándo salir
-- (cuando la cola está realmente vacía y no solo bloqueada).
SELECT COUNT(*) FROM input WHERE status = 'pending';

-- name: ResetInputStatus :exec
-- vuelve todas las tareas a 'pending'
-- para poder re-ejecutar sin recrear la BD.
UPDATE input
SET status = 'pending';
