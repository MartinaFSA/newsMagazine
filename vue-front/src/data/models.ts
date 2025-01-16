export interface IArticle {
    id: number
    type: string
    tags: string
    title: string
    authors: string
    artist: string
    coverImg: string
    date: string
    summary: string
    category: string
    body: string
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