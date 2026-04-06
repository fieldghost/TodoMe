# TodoMe

Create, list, complete, delete, and clear your to-dos straight from the terminal, baby. 

TodoMe is a minimal, fast, and reliable CLI tool to help you track your daily tasks without ever leaving your command line.

---

## Prerequisites

The core script runs flawlessly on any POSIX-compliant system (Linux, macOS, WSL). However, if you want to use the `remind` feature, your system needs `notify-send` to push desktop notifications.

- **Ubuntu / Debian:**
  sudo apt-get install libnotify-bin
- **Other Linux Distributions:**
Install it via your standard package manager, or visit [vaskovsky.net](https://vaskovsky.net/notify-send/linux.html) for guidance.
- **macOS:** *Note: `notify-send` is not native to macOS. The core to-do list will work perfectly, but the `remind` feature will prompt you to install a compatible notification wrapper.*

---

## Installation

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

## Usage

**Syntax:**

```bash
todo [ command ] [ argument ] [ minutes ]
```

### Commands

- `**todo add <task...>**`
Adds a new task to your list. No quotes required!
*Example:* `todo add Pet the dog`
- `**todo list`**
Displays all current tasks with their line numbers and completion status.
- `**todo done <number>*`*
Marks a specific task as completed `[x]`.
*Example:* `todo done 1`
- `**todo remove <number>`**
Deletes a specific task. Prompts for confirmation before deleting.
*Example:* `todo remove 2`
- `**todo clear`**
Wipes your entire to-do list. Prompts for confirmation.
- `**todo remind <number> <minutes>*`*
Sends a one-shot desktop notification for a specific task after *X* minutes (runs a safe background process, does not clutter your cron schedule).
*Example:* `todo remind 1 15` (Reminds you of task #1 in 15 minutes).
- `**todo help` (or `-h`, `--help`)**
Displays the built-in help menu and usage syntax.

---

Free to use. Open source. Lovely.