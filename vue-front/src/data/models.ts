export interface IArticle {
    id: number
    title: string
    type: string
    tags: string
    summary: string
    body: string
    authors: string
    date: string
    coverImg: string
    artist: string
    category: string
}
export interface IWriter {
    id: number
    name: string
    bio: string
    profession: string
    location: string
    socialMedia: string
}
export interface IArtist {
    id: number
    name: string
    bio: string
    profession: string
    location: string
    socialMedia: string
}