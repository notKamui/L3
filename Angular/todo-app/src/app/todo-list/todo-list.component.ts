declare var M: any;

import { Component } from '@angular/core';
import { Todo } from '../../model/todo';
import { TodoService } from '../todo.service';

@Component({
  selector: 'app-todo-list',
  templateUrl: './todo-list.component.html',
  styleUrls: ['./todo-list.component.css']
})
export class TodoListComponent {

  service = new TodoService();
  newTodo = '';
  newDescription = '';

  addNewTodo(): void {
    if (this.newTodo.length <= 0 || this.newDescription.length <= 0) { return; }
    this.service.createTodo(this.newTodo, this.newDescription);
    M.toast({html: 'The task ' + this.newTodo + ' has been added !'});
    this.newTodo = '';
    this.newDescription = '';
  }

  deleteTodo(todo: Todo): void {
    M.toast({html: 'The task ' + todo.label + ' has been deleted !'});
    this.service.deleteTodo(todo);
  }

  handleKeyUp(event: KeyboardEvent): void {
    if (event.key === 'Enter') {
      this.addNewTodo();
    }
  }

  handleEdit(event: Todo): void {
    this.service.updateTodo(event);
    M.toast({html: 'The task ' + event.label + ' has been updated !'});
  }
}
