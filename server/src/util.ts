export const defineEventHandler=(handle:(req?:any)=>Record<string,any>)=>{
    return (event: any) => {
        const result = handle();
        return result;
    }
}