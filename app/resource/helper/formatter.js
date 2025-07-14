
/* eslint-disable prefer-template */

export function numberWithCommas(data) {
  return data.value ? data.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') : null;
}

export function percentValue(data) {
  return data.value ? data.value + '%' : null;
}

export function yearOfDate(data) {
  return data.value
    ? '1' + data.value.substr(0, 3)
    : null;
}

export function dateFormat(data) {
  return data.value
    ? '1' +
        data.value.substr(0, 3) +
        '/' +
        data.value.substr(3, 2) +
        '/' +
        data.value.substr(5, 2)
    : null;
}

export function dateFormatLabel(data) {
  return data
    ? '1' +
        data.substr(0, 3) +
        '/' +
        data.substr(3, 2) +
        '/' +
        data.substr(5, 2)
    : null;
}

export function percentFormatLabel(data) {
  return data ? data + '%' : null;
}

export function timeFormat(data) {
  return data.value
  ? +
  data.value.substr(0, 2) +
  ':' +
  data.value.substr(2, 3) 
  : null;
}