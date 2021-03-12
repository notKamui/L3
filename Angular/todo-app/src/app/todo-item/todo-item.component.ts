import { Component, EventEmitter, Input, Output } from '@angular/core';
import { Todo } from 'src/model/todo';

@Component({
  selector: 'app-todo-item',
  templateUrl: './todo-item.component.html',
  styleUrls: ['./todo-item.component.css']
})
export class TodoItemComponent {

  @Input()
  todo: Todo = { id: '', label: '', creationDate: Date.now().valueOf(), done: false };

  @Output()
  editEmitter = new EventEmitter<Todo>();

  @Output()
  deleteEmitter = new EventEmitter<undefined>();

  isInEditMode = false;

  constructor() { }

  toggleDone(): void {
    this.todo.done = !this.todo.done;
    this.editEmitter.emit(this.todo);
  }

  toggleEditMode(): void {
    this.isInEditMode = !this.isInEditMode;
  }

  handleKeyUp(event: KeyboardEvent): void {
    if (event.key === 'Enter') {
      if (this.todo.label.length <= 0) { return; }
      this.toggleEditMode();
      this.editEmitter.emit(this.todo);
    }
  }

  deleteSelf(): void {
    this.deleteEmitter.emit();
  }
}
