const locationSuccess = (position) => {
    const latitude = position.coords.latitude;
    const longitude = position.coords.longitude;
    console.log(latitude);
    console.log(longitude);
}

const locationError = error => {
    const code = error.code;
    const message = error.message;
};

navigator.geolocation.getCurrentPosition(locationSuccess, locationError);