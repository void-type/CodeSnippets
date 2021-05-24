# miscCodeTips
Little tips and tricks

```sql
-- split a string and get it's first parts as one column and last part as another.
SELECT
  REPLACE(REPLACE(LEFT(tbl.addr, LEN(tbl.addr) - CHARINDEX(CHAR(10), REVERSE(tbl.addr)+CHAR(10)) + 1), CHAR(10), ' '), CHAR(13), '') as street,
  REPLACE(REPLACE(RIGHT(tbl.addr, CHARINDEX(CHAR(10), REVERSE(tbl.addr) + CHAR(10)) - 1), CHAR(10), ' '), CHAR(13), '') as city
FROM (VALUES
    (N'123 way'+ CHAR(13)+CHAR(10) +'Fort Collins'),
    (N'someone'+ CHAR(13)+CHAR(10) +'123 way'+ CHAR(13)+CHAR(10) +'Fort Collins'),
    (CHAR(13)+CHAR(10) +'Fort Collins'),
    (N'Fort Collins')) as tbl(addr)


-- sort IP addresses
Select
  [IpAddress]
From [Equipment]
Where RTRIM(LTRIM([IpAddress])) NOT LIKE ''
ORDER BY CAST(PARSENAME([IPAddress], 4) AS INT),
         CAST(PARSENAME([IPAddress], 3) AS INT),
         CAST(PARSENAME([IPAddress], 2) AS INT),
         CAST(PARSENAME([IPAddress], 1) AS INT)

-- See the size of all tables
SELECT
  t.NAME AS TableName,
  s.Name AS SchemaName,
  p.rows AS RowCounts,
  SUM(a.total_pages) * 8 AS TotalSpaceKB,
  CAST(ROUND(((SUM(a.total_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS TotalSpaceMB,
  SUM(a.used_pages) * 8 AS UsedSpaceKB,
  CAST(ROUND(((SUM(a.used_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS UsedSpaceMB,
  (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpaceKB,
  CAST(ROUND(((SUM(a.total_pages) - SUM(a.used_pages)) * 8) / 1024.00, 2) AS NUMERIC(36, 2)) AS UnusedSpaceMB
FROM
  sys.tables t
  INNER JOIN
  sys.indexes i ON t.OBJECT_ID = i.object_id
  INNER JOIN
  sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
  INNER JOIN
  sys.allocation_units a ON p.partition_id = a.container_id
  LEFT OUTER JOIN
  sys.schemas s ON t.schema_id = s.schema_id
WHERE
    t.NAME NOT LIKE 'dt%'
  AND t.is_ms_shipped = 0
  AND i.OBJECT_ID > 255
GROUP BY
    t.Name, s.Name, p.Rows
ORDER BY
    UsedSpaceMB Desc,
       t.Name
```
