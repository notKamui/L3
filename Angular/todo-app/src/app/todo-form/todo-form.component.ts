import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';

@Component({
  selector: 'app-todo-form',
  templateUrl: './todo-form.component.html',
  styleUrls: ['./todo-form.component.css'],
})
export class TodoFormComponent implements OnInit {
  @Output()
  todoNameEmitter = new EventEmitter<string>();

  @Input()
  buttonMessage = 'Add new todo';

  todoName = '';

  constructor() {}

  ngOnInit(): void {}

  sendNewTodo(): void {
    this.todoNameEmitter.emit(this.todoName);
    this.todoName = '';
  }

  computedLength(): string {
    return this.todoName.length + '/20';
  }
}
