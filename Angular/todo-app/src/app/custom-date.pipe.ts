import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'customdate'
})
export class CustomDatePipe implements PipeTransform {
  transform(value: number, withClock?: boolean): string {
    const date = new Date(value);
    let format = date.getDate() + '/' + date.getMonth() + '/' + date.getFullYear();
    if (withClock) {
      format += ' ' + date.getHours() + ':' + date.getMinutes();
    }
    return format;
  }
}
