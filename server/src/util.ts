export const defineEventHandler=(handle:(req?:any)=>Record<string,any>)=>{
    return (req: any) => {
        const result = handle(req);
        return result;
    }
}