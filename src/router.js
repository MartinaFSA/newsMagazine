import { createWebHistory, createRouter } from 'vue-router'

import LandingPage from './views/LandingPage.vue' 
import AllArticles from './views/AllArticles.vue'
import CollaboratorProfile from './views/CollaboratorProfile.vue'
import AllCollaborators from './views/AllCollaborators.vue'
import About from './views/About.vue'
import Profile from './views/Profile.vue'
import WriteArticle from './components/WriteArticle.vue'
import Article from './views/Article.vue'
import NotFound from './views/NotFound.vue'

const routes = [
    { path: '/', component: LandingPage },
    { path: '/allArticles', component: AllArticles },
    { path: '/allCollaborators', component: AllCollaborators },
    { path: '/collaborator/:id', component: CollaboratorProfile },
    { path: '/about', component: About },
    { path: '/profile', component: Profile },
    { path: '/writeArticle', component: WriteArticle },
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