# TodoMe

Create, list, complete, delete, and clear your to-dos straight from the terminal, baby. 

TodoMe is a minimal, fast, and reliable CLI tool to help you track your daily tasks without ever leaving your command line.

🔗 **[View on GitHub](https://github.com/fieldghost/TodoMe)**

---

## ⚠️ Prerequisites

If you want to use the `remind` feature, your system needs `notify-send` to push desktop notifications.

* **Ubuntu:**
    ```bash
    sudo apt-get install notify-osd
    ```
* **Debian:**
    ```bash
    sudo apt-get install libnotify-bin
    ```
* **Other Distributions:**
    Install it via your standard package manager, or visit [vaskovsky.net](https://vaskovsky.net/notify-send/linux.html) for guidance.

---

## 🛠️ Installation

1. Download or clone the script to your machine.
2. Make it executable:
   ```bash
   chmod +x TodoMe.sh
   ```
3. Move it to a safe location (e.g., `~/scripts/TodoMe.sh`).
4. Add an alias to your `~/.bashrc` (or `~/.zshrc`) for quick access:
   ```bash
   alias todo="~/scripts/TodoMe.sh"
   ```
5. Source your config:
   ```bash
   source ~/.bashrc
   ```

*(Note: TodoMe automatically creates a `~/.todo_list_data` file in your home directory to store your tasks).*

---

## 💻 Usage

**Syntax:**
```bash
todo [ command ] [ argument ] [ minutes ]
```

### Commands

* **`todo add "<task>"`**
    Adds a new task to your list.
    *Example:* `todo add "Pet the dog"`

* **`todo list`**
    Displays all current tasks with their line numbers and completion status.

* **`todo done <number>`**
    Marks a specific task as completed `[x]`.
    *Example:* `todo done 1`

* **`todo remove <number>`**
    Deletes a specific task. Prompts for confirmation before deleting.
    *Example:* `todo remove 2`

* **`todo clear`**
    Wipes your entire to-do list. Prompts for confirmation.

* **`todo remind <number> <minutes>`**
    Sets up a cron job to send you a desktop notification for a specific task every *X* minutes. 
    *Example:* `todo remind 1 15` (Reminds you of task #1 every 15 minutes).
    *(Warning: This adds a recurring job to your crontab. You will need to manually remove it using `crontab -e` when you no longer need the reminder).*

---

Free to use. Open source. Lovely.
