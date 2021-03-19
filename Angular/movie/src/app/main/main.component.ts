import { Component, OnInit } from "@angular/core";
import { MovieShortInformations } from "../model/movie";
import { MovieService } from "../movie.service";

@Component({
  selector: "app-main",
  templateUrl: "./main.component.html",
  styleUrls: ["./main.component.css"],
})
export class MainComponent implements OnInit {
  movies: MovieShortInformations[];

  constructor(private service: MovieService) {}

  ngOnInit() {}

  fetchMovies(search: string): void {
    this.service.search(search).subscribe((res) => (this.movies = res));
  }
}
