export function scrollTo (elementId: string) {
    const element = document.getElementById(elementId);
    element?.scrollIntoView({ behavior: "smooth", block: "start", inline: "nearest" });
}
export function dbUrl() {;
    return 'http://localhost:3000/data/';
}
export function toSlug(str: string) {
    const cleanStr = str
      .normalize('NFD')
      .replace(/[\u0300-\u036f]/g, '')
      .replace(/[^\w\s-]/g, '')
      .replace(/\s+/g, '-')
  
    return cleanStr.toLowerCase()
}
  
export function isElementInViewport (el: HTMLElement | null) {
    const rect = el?.getBoundingClientRect();
    if (rect) {
      return (
          rect.top >= 0 &&
          rect.left >= 0 &&
          rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
          rect.right <= (window.innerWidth || document.documentElement.clientWidth)
      )
    }
    else {return false}
}