import { Component, OnInit } from '@angular/core';
import { Todo } from '../../model/todo';

@Component({
  selector: 'app-todo-list',
  templateUrl: './todo-list.component.html',
  styleUrls: ['./todo-list.component.css']
})
export class TodoListComponent {

  public todos = new Set<Todo>();
  public newTodo = '';

  toggleDone(todo: Todo): void {
    todo.done = !todo.done;
  }

  addNewTodo(): void {
    if (this.newTodo.length <= 0) { return; }
    this.todos.add({ label: this.newTodo, done: false });
    this.newTodo = '';
  }

  deleteTodo(todo: Todo): void {
    this.todos.delete(todo);
  }

  handleKeyUp(event: KeyboardEvent): void {
    if (event.key === 'Enter') {
      this.addNewTodo();
    }
  }
}
