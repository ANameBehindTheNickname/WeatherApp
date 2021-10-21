<h1 align="center">
  <img src="https://user-images.githubusercontent.com/88666686/138146646-483ed5e4-dc6b-4dbf-9137-0f573c7a60e1.png" width="200px"/></br>
  WeatherApp</br>
  <img src="https://img.shields.io/badge/iOS-14.0+-00ADD8?style=for-the-badge&logo=apple"/>
</h1>

# Description (and intention)
I wanted to build an iOS app with DI practices in mind. 

The project is separated into UI/Domain/Data/Main folders, but you can cut them out into separate targets. A modular design allows that (just pay attention to the access control).

Oh, right. It's a weather app 🙂</br>
I use “Current Weather Data” and “5 Day / 3 Hour Forecast” APIs from OpenWeather.

It is loosely coupled so <b>you can use a different weather API if you wish</b>. Create a class conforming to WeatherAPI protocol from Domain module and inject it into WeatherAPItoServiceAdapter (created inside SceneDelegate).

# App architecture
This is a simplified version of the app’s architecture.</br>
<img src="https://user-images.githubusercontent.com/88666686/138285159-679ed101-144e-46f5-8d6e-742b63c1cc4f.jpeg"/>

# Screenshots
Dark Mode is also supported.</br>
<img src="https://user-images.githubusercontent.com/88666686/138291106-da7e57ab-295e-4bdd-905a-2b1cf0c58108.png" width="240px"/>
<img src="https://user-images.githubusercontent.com/88666686/138291112-c44869ca-a89b-4813-b1a8-dbc441afb6bd.png" width="240px"/>
<img src="https://user-images.githubusercontent.com/88666686/138291101-7ef798c7-db7e-4a80-b713-9a0461885294.png" width="240px"/>
<img src="https://user-images.githubusercontent.com/88666686/138291088-3e1b2f94-411a-45ac-9b16-59dcf8d26fb9.png" width="240px"/>

# API
<b>OpenWeather APIs</b>
<ul>
  <li> <a href="https://openweathermap.org/current">Current Weather Data</a> </li>
  <li> <a href="https://openweathermap.org/forecast5">5 Day / 3 Hour Forecast</a> </li>
</ul>

# How to install
<ul>
  <li>git clone / download a zip</li>
  <li>search for <code>ENTER_YOUR_OPEN_WEATHER_API_KEY</code> string and replace with your own OpenWeather API key</li>
  <li>build and run</li>
</ul></br>
No external dependencies

# License
This project is licensed under BSD-3-Clause License. See [LICENSE](LICENSE) for details.
