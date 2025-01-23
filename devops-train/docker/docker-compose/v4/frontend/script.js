// URL для обращения к API бэкенда
const apiUrl = '/api/users';

// Функция для получения списка пользователей с бэкенда
async function fetchUsers() {
    try {
        // Отправляем GET-запрос к API
        const response = await fetch(apiUrl);

        // Проверяем, успешен ли запрос
        if (!response.ok) {
            throw new Error(`Ошибка HTTP: ${response.status}`);
        }

        // Парсим ответ в JSON
        const users = await response.json();

        // Обновляем DOM с полученными данными
        displayUsers(users);
    } catch (error) {
        // Если произошла ошибка, отображаем сообщение об ошибке
        showError(error.message);
    }
}

// Функция для отображения списка пользователей в HTML
function displayUsers(users) {
    const userList = document.getElementById('user-list');
    userList.innerHTML = ''; // Очищаем контейнер

    if (users.length === 0) {
        userList.innerHTML = '<p>Пользователи не найдены.</p>';
        return;
    }

    const ul = document.createElement('ul');

    // Создаем элемент списка для каждого пользователя
    users.forEach(user => {
        const li = document.createElement('li');
        li.textContent = `${user.id}: ${user.name}`;
        ul.appendChild(li);
    });

    userList.appendChild(ul);
}

// Функция для отображения сообщения об ошибке
function showError(message) {
    const userList = document.getElementById('user-list');
    userList.innerHTML = `<p class="error">Ошибка: ${message}</p>`;
}

// Запуск функции получения пользователей при загрузке страницы
document.addEventListener('DOMContentLoaded', fetchUsers);
