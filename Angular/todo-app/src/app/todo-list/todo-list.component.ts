declare var M: any;

import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Todo } from '../../model/todo';
import { TodoService } from '../todo.service';

@Component({
  selector: 'app-todo-list',
  templateUrl: './todo-list.component.html',
  styleUrls: ['./todo-list.component.css'],
})
export class TodoListComponent implements OnInit {
  todos: Todo[] = [];
  private username = '';

  constructor(private service: TodoService, private route: ActivatedRoute) {}

  ngOnInit(): void {
    this.username = this.route.snapshot.paramMap.get('username') ?? '';
    this.fetchTodos();
  }

  fetchTodos(): void {
    this.service
      .getTodos(this.username)
      .subscribe((res: Todo[]) => (this.todos = res));
  }

  addNewTodo(newTodo: string): void {
    if (newTodo.length <= 0) {
      return;
    }
    this.service
      .createTodo(this.username, newTodo)
      .subscribe((res: boolean) => {
        if (res) {
          M.toast({ html: 'The task ' + newTodo + ' has been added !' });
        } else {
          M.toast({
            html: 'The task ' + newTodo + ' has failed to be added !',
          });
        }
      });
    this.fetchTodos();
    newTodo = '';
  }

  deleteTodo(todo: Todo): void {
    this.service.deleteTodo(this.username, todo).subscribe((res: boolean) => {
      if (res) {
        M.toast({ html: 'The task ' + todo.label + ' has been deleted !' });
      } else {
        M.toast({
          html: 'The task ' + todo.label + ' has failed to be deleted !',
        });
      }
    });
    this.fetchTodos();
  }

  handleEdit(event: Todo): void {
    this.service.updateTodo(this.username, event).subscribe((res: boolean) => {
      if (res) {
        M.toast({ html: 'The task ' + event.label + ' has been updated !' });
      } else {
        M.toast({
          html: 'The task ' + event.label + ' failed to be updated !',
        });
      }
    });
    this.fetchTodos();
  }
}
