declare var M: any;

import { Component } from '@angular/core';
import { Todo } from '../../model/todo';

@Component({
  selector: 'app-todo-list',
  templateUrl: './todo-list.component.html',
  styleUrls: ['./todo-list.component.css']
})
export class TodoListComponent {

  todos = new Set<Todo>();
  newTodo = '';
  newDescription = '';

  addNewTodo(): void {
    if (this.newTodo.length <= 0 || this.newDescription.length <= 0) { return; }
    this.todos.add({ label: this.newTodo, description: this.newDescription, done: false });
    M.toast({html: 'The task ' + this.newTodo + ' has been added !'});
    this.newTodo = '';
    this.newDescription = '';
  }

  deleteTodo(todo: Todo): void {
    M.toast({html: 'The task ' + todo.label + ' has been deleted !'});
    this.todos.delete(todo);
  }

  handleKeyUp(event: KeyboardEvent): void {
    if (event.key === 'Enter') {
      this.addNewTodo();
    }
  }

  handleEdit(event: string): void {
    M.toast({html: event});
  }
}
