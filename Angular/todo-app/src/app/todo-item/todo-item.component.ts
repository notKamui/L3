import { Component, EventEmitter, Input, Output } from '@angular/core';
import { Todo } from 'src/model/todo';

@Component({
  selector: 'app-todo-item',
  templateUrl: './todo-item.component.html',
  styleUrls: ['./todo-item.component.css']
})
export class TodoItemComponent {

  @Input()
  todo: Todo = { label: '', description: '', done: false };

  @Output()
  editEmitter = new EventEmitter<string>();

  @Output()
  deleteEmitter = new EventEmitter<undefined>();

  isInEditMode = false;

  constructor() { }

  toggleDone(): void {
    this.todo.done = !this.todo.done;
  }

  toggleEditMode(): void {
    this.isInEditMode = !this.isInEditMode;
  }

  handleKeyUp(event: KeyboardEvent): void {
    if (event.key === 'Enter') {
      if (this.todo.label.length <= 0 || this.todo.description.length <= 0) { return; }
      this.toggleEditMode();
      this.editEmitter.emit('The task ' + this.todo.label + ' has been updated !');
    }
  }

  deleteSelf(): void {
    this.deleteEmitter.emit();
  }
}
