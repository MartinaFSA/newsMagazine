import { createWebHistory, createRouter } from 'vue-router'

import LandingPage from './views/LandingPage.vue' 
import AllArticles from './views/AllArticles.vue'
import Collaborator from './views/Collaborator.vue'
import About from './views/About.vue'
import Article from './views/Article.vue'
import NotFound from './views/NotFound.vue'

const routes = [
    { path: '/', component: LandingPage },
    { path: '/allArticles', component: AllArticles },
    { path: '/collaborator', component: Collaborator },
    { path: '/about', component: About },
    { path: '/article/:id', component: Article },
    { path: '/:pathMatch(.*)*', name: 'NotFound', component: NotFound },    
]

const router = createRouter({
    scrollBehavior() {
        return { x: 0, y: 0 };
    },
    history: createWebHistory(),
    routes,
})

export default router