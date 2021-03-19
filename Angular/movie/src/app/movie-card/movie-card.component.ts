import { Component, Input, OnInit } from "@angular/core";
import { MovieFullInformations, MovieShortInformations } from "../model/movie";
import { MovieService } from "../movie.service";

@Component({
  selector: "app-movie-card",
  templateUrl: "./movie-card.component.html",
  styleUrls: ["./movie-card.component.css"],
})
export class MovieCardComponent implements OnInit {
  @Input()
  movie: MovieShortInformations;

  fullInfo: MovieFullInformations;

  showFull = false;

  constructor(private service: MovieService) {}

  ngOnInit() {}

  toggleFullInfo(): void {
    this.showFull = !this.showFull;
    if (this.showFull) {
      this.fetchFullInfo();
    }
  }

  fetchFullInfo(): void {
    this.service
      .getFullMovieInformation(this.movie.imdbID)
      .subscribe((data) => (this.fullInfo = data));
  }
}
