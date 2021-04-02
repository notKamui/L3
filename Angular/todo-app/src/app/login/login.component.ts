import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
})
export class LoginComponent implements OnInit {
  username = '';

  constructor(private router: Router) {}

  ngOnInit(): void {}

  loginAsUser(): void {
    this.router.navigate(['/todos/' + this.username]);
  }
}
