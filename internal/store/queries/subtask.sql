-- name: CreateSubtask :one
INSERT INTO
    subtask (name, description, pomos_required, task_id)
VALUES
    ($1, $2, $3, $4) RETURNING *;

-- name: CompleteSubtask :one
UPDATE subtask
SET
    completed_at = NOW ()
WHERE
    id = $1 RETURNING *;

-- name: DeleteSubtask :exec
DELETE FROM subtask
WHERE
    id = $1;

-- name: GetSubtasksOfTask :many
SELECT
    *
FROM
    subtask
where
    task_id = $1;