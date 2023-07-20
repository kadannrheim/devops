sysbench - утилита тестирования производительности


# Тестирование дисковой подсистемы
Генерация файлов:
sysbench --num-threads=16 --test=fileio --file-total-size=3G --file-test-mode=rndrw prepare

Тестирование:
sysbench --num-threads=16 --test=fileio --file-total-size=3G --file-test-mode=rndrw run

Удаление файлов программы:
sysbench --num-threads=16 --test=fileio --file-total-size=3G --file-test-mode=rndrw cleanup

## Ещё тест
sysbench fileio --threads=16 --file-total-size=5G --file-test-mode=rndrw --time=30 --max-requests=0 run