import { createApp } from 'vue'
import App from '../components/App.vue'
import '../styles/application.css'

const mountPoint = document.querySelector('#vue-app')

if (mountPoint) {
  createApp(App).mount(mountPoint)
}
