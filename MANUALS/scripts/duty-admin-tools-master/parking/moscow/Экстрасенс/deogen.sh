#!/bin/bash
dates=$1 #2023-01-19
argument=$2 #Что-там

# Устанавливаем путь к директории с файлами, которые нужно обработать
dir="/backup/s3/data/mskparking/logs/$dates"

# Создаем новый файл, в который будут записаны все строки с ключевым словом
output_file="output.txt"
rm -f "$output_file"

# Проходимся по всем файлам с расширением .gz в директории
for file in "$dir"/*.gz
do
  # Используем zcat для чтения содержимого архива без его извлечения
    echo "${file:43}--->>>" >> "$output_file"
    zcat "$file" | grep "$argument" >> "$output_file"
done

echo "Обработка файлов завершена. Результат сохранен в $output_file."

