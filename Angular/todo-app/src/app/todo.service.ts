import { Injectable } from '@angular/core';
import { Todo } from 'src/model/todo';

@Injectable({
  providedIn: 'root'
})
export class TodoService {
  todos: Todo[];

  constructor() {
    if (typeof(Storage) !== 'undefined') {
      const list = localStorage.getItem('todoapplist');
      if (list) {
        this.todos = JSON.parse(list);
      } else {
        localStorage.setItem('todoapplist', JSON.stringify([]));
        this.todos = [];
      }
    } else {
      this.todos = [];
    }
  }

  getTodos(): Todo[] {
    return Array.from(this.todos);
  }

  createTodo(label: string, description: string): void {
    this.todos.push({
      id: Math.floor(Math.random() * 1000),
      label,
      description,
      creationDate: Date.now().valueOf(),
      done: false
    });
    localStorage.setItem('todoapplist', JSON.stringify(this.todos));
  }

  updateTodo(todo: Todo): void {
    const i = this.todos.findIndex(t => t.id === todo.id);
    this.todos[i] = todo;
    localStorage.setItem('todoapplist', JSON.stringify(this.todos));
  }

  deleteTodo(todo: Todo): void {
    this.todos = this.todos.filter(t => t.id !== todo.id);
    localStorage.setItem('todoapplist', JSON.stringify(this.todos));
  }
}
