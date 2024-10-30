<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Web Folder</title>
</head>
<body>
    <h1>File List</h1>
    <ul>
        <?php
            $files = scandir(__DIR__);
            foreach ($files as $file) {
                if ($file !== "." && $file !== ".." && $file !== "index.php") {
                    echo "<li><a href='$file'>$file</a></li>";
                }
            }
        ?>
    </ul>
</body>
</html>
