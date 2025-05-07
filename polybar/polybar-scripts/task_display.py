#!/usr/bin/env python3

from datetime import datetime
import os
import json
import time

# Cache file to store the task data
TASK_CACHE_FILE = "/tmp/tasks_cache.json"

def load_tasks(file_path):
    """Loads tasks from a file."""
    tasks = {}
    with open(file_path, 'r') as file:
        for line in file:
            time_str, task = line.strip().split(' ', 1)
            tasks[time_str] = task
    return tasks

def get_task_for_time(tasks, query_time):
    """Returns the most recent task for a specific time."""
    sorted_times = sorted(tasks.keys())  # Sort times in ascending order
    previous_task = "No task"
    for time in sorted_times:
        if time <= query_time:
            previous_task = tasks[time]
        else:
            break
    return previous_task

def get_cached_tasks(file_path):
    """Retrieve cached tasks or reload from file."""
    if os.path.exists(TASK_CACHE_FILE):
        # Check if the file has been modified
        file_mod_time = os.path.getmtime(file_path)
        cache_mod_time = os.path.getmtime(TASK_CACHE_FILE)

        if file_mod_time > cache_mod_time:
            # Cache is outdated, reload the tasks from the file
            tasks = load_tasks(file_path)
            with open(TASK_CACHE_FILE, 'w') as cache_file:
                json.dump(tasks, cache_file)
            return tasks
        else:
            # Use the cached tasks
            with open(TASK_CACHE_FILE, 'r') as cache_file:
                return json.load(cache_file)
    else:
        # No cache exists, load tasks from the file and create cache
        tasks = load_tasks(file_path)
        with open(TASK_CACHE_FILE, 'w') as cache_file:
            json.dump(tasks, cache_file)
        return tasks

def main():
    # Define the subdirectory and file name
    subdirectory = "dev/calendar"
    file_name = "tasks.txt"
    file_path = os.path.join(os.getcwd(), subdirectory, file_name)
    
    # Get the current time in HH:MM format
    current_time = datetime.now().strftime("%H:%M")
    
    # Load tasks from cache or file
    tasks = get_cached_tasks(file_path)
    task = get_task_for_time(tasks, current_time)
    
    print(task)  # Output only the task for Polybar

if __name__ == "__main__":
    main()
