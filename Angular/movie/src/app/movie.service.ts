import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Observable, of } from "rxjs";
import { map } from "rxjs/operators";
import {
  MovieFullInformations,
  MovieShortInformations,
  SearchResponse,
} from "./model/movie";

@Injectable({
  providedIn: "root",
})
export class MovieService {
  private apiKey = "642219f8";
  private url: string = "http://www.omdbapi.com/?apikey=" + this.apiKey;

  constructor(private httpClient: HttpClient) {}

  search(title: string): Observable<MovieShortInformations[]> {
    return this.httpClient
      .get<SearchResponse>(this.url + "&s=" + title)
      .pipe(map((res) => res.Search));
  }

  getFullMovieInformation(id: string): Observable<MovieFullInformations> {
    return this.httpClient.get<MovieFullInformations>(this.url + "&i=" + id);
  }
}
