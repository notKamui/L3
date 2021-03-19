import { Component, EventEmitter, OnInit, Output } from "@angular/core";

@Component({
  selector: "app-navbar",
  templateUrl: "./navbar.component.html",
  styleUrls: ["./navbar.component.css"],
})
export class NavbarComponent implements OnInit {
  @Output()
  searchEmitter = new EventEmitter<string>();

  search: string;

  constructor() {}

  ngOnInit() {
    this.search = "";
  }

  emitSearchValue(): void {
    if (this.search.length > 0) {
      this.searchEmitter.emit(this.search);
    }
  }
}
