const calculateDeliveryPrice = (position) => {
    const latitude = position.coords.latitude
    const longitude = position.coords.longitude
    console.log(latitude)
    console.log(longitude)
    calculating(latitude, longitude)
    document.getElementById("delPrice").innerText = calculating(latitude, longitude);
};

const calculating = (lat1, lon1) => {
    // some random japan location
    const [lat2, lon2] = [35.55724734257086, 137.74741764337156]
    const distance = () => {
        const r = 6371 //radios of Earth
        const p = 0.017453292519943295 //pi/180
        const a = 0.5 -
            Math.cos((lat2 - lat1) * p) / 2 +
            Math.cos(lat1 * p) *
            Math.cos(lat2 * p) *
            (1 - Math.cos((lon2 - lon1) * p)) / 2
        return 2 * r * Math.asin(Math.sqrt(a))
    };
    if (distance() < 200) {
        return 20
    } else {
        return (distance() / 2).toFixed(0)
    }
};

const locationError = error => {
    const code = error.code;
    const message = error.message;
};

navigator.geolocation.getCurrentPosition(calculateDeliveryPrice, locationError);


