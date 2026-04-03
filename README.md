# TodoMe

> "Chrome is running slow. I need to download some more ram."
> ....
> "Yo. The deadline for release is in 17 minutes."
> ....
> "Have you said 'I use Arch btw' today?"
> ....

Slouchingly typing away in your favourite Subreddit you get the:
* Inevitable ping from the PM
* A 'lovely' text from the wife (no gender assumption. Wife is the CEO, PM, CFO and Floor Manager of the relationship)
* A fleeting ADHD neuron spark that seems slightly more stimulating than the current debate you have with Flower-Basket-95 on /r/Fedora/ about whether or not a Fedora is a way of living, or a clothing accessory that represents a way of living.

You scramble to free a little bit of memory in your otherwise fully utilized brain of yours, only to realise that 17 hours has passed and all hope is gone.

That is until you discover **TodoMe** - the ultra reliable, minimal, maximal terminal tool to help you remember and action on your *"Yes i'll do that today"* (Or give you a system to track all the promises you give but fail to fulfill during your day).

---

## Requirements

`notify-send` (I gots to remind you)

* **Ubuntu**
    ```bash
    sudo apt-get install notify-osd
    ```
* **Debian**
    ```bash
    sudo apt-get install libnotify-bin
    ```
* **Something else?**
    Please find it and install it via your package manager, or visit [vaskovsky.net](https://vaskovsky.net/notify-send/linux.html).

---

## Instructions

1. Copy/Download/Steal the script.
2. Store in a path/that/you/can/find/again.
3. For the chads - add an alias in your `~/.bashrc`:
   ```bash
   alias todo="~/path/to/the/script/name_of_the_script.sh"
   ```
4. Enjoy your todo.

---

## How To Use

**Syntax:**
```bash
todo [ add | list | done | remove | clear | remind ] [ ARGUMENT ] [ MINUTES ]
```

### Commands

* **`todo add "Pet the dog"`**
    Adds new todo.

* **`todo list`**
    Lists all current todos.
    *Format: `<number> <completion_indicator> <todo_name>`*

* **`todo done <todo_number>`**
    Marks a specific todo as done `[x]`.

* **`todo remove <todo_number>`**
    Deletes a specific todo. 
    *(Will ask for confirmation. Yeah, I am that nice.)*

* **`todo clear`**
    Deletes all your todos.
    *(I also added a confirmation prompt here. You are welcome.)*

* **`todo remind <todo_number> <reminder_minutes>`**
    Adds a cronjob to execute a `notify-send` in `<reminder_minutes>`.

---

Free to use. Open source. Lovely.
