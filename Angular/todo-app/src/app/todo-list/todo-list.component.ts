declare var M: any;

import { Component, OnInit } from '@angular/core';
import { Observer } from 'rxjs';
import { Todo } from '../../model/todo';
import { TodoService } from '../todo.service';

@Component({
  selector: 'app-todo-list',
  templateUrl: './todo-list.component.html',
  styleUrls: ['./todo-list.component.css']
})
export class TodoListComponent implements OnInit{
  todos: any = [];
  newTodo = '';
  isLoading = false;

  constructor(public service: TodoService) {}

  ngOnInit(): void {
    this.fetchTodos();
  }

  fetchTodos(): void {
    this.isLoading = true;
    this.service.getTodos().subscribe(res =>
      this.todos = res
    );
    this.isLoading = false;
  }

  addNewTodo(): void {
    if (this.newTodo.length <= 0) { return; }
    this.service.createTodo(this.newTodo).subscribe((res: boolean) => {
      if (res) {
        M.toast({html: 'The task ' + this.newTodo + ' has been added !'});
      } else {
        M.toast({html: 'The task ' + this.newTodo + ' has failed to be added !'});
      }
    });
    this.fetchTodos();
    this.newTodo = '';
  }

  deleteTodo(todo: Todo): void {
    this.service.deleteTodo(todo).subscribe((res: boolean) => {
      if (res) {
        M.toast({html: 'The task ' + todo.label + ' has been deleted !'});
      } else {
        M.toast({html: 'The task ' + todo.label + ' has failed to be deleted !'});
      }
    });
    this.fetchTodos();
  }

  handleKeyUp(event: KeyboardEvent): void {
    if (event.key === 'Enter') {
      this.addNewTodo();
    }
  }

  handleEdit(event: Todo): void {
    this.service.updateTodo(event).subscribe((res: boolean) => {
      if (res) {
        M.toast({html: 'The task ' + event.label + ' has been updated !'});
      } else {
        M.toast({html: 'The task ' + event.label + ' failed to be updated !'});
      }
    });
    this.fetchTodos();
  }
}
