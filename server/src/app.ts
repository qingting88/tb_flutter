import express from 'express'
import { glob } from 'glob'


async function main() {
    const app = express()

    app.use(express.json())
    const pages = await glob(`./api/**/*.ts`, {
        cwd: __dirname
    })
    for await (const file of pages) {
        const module = await import(`./${file}`)
        const paths = file.split('/')
        const [name, methods, ext] = paths.slice(-1)[0].split('.')
        let _methods = 'all'
        if (ext) {
            _methods = methods
        }
        const url = name === 'index' ? `/${paths.slice(0, -1).join('/')}` : `/${paths.slice(0, -1).join('/')}/${name}`
        app[_methods as 'all'](url, async (req, res) => {
            const data = await module.default(req)
            res.json(data)
        })
    }
    const PORT = 3000

    // 启动
    app.listen(PORT, async () => {
        console.log(`App is running at http://localhost:${PORT}`)
    })
}

main();