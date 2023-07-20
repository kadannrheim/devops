Если запускать на винде через vagrant убедись что включена поддержка виртуализации
```
grep -E --color 'vmx|svm' /proc/cpuinfo
```
Если вывод пуст то манул здесь: https://alpinefile.ru/virtualbox-nested-vt-x-amd-v-on.html
