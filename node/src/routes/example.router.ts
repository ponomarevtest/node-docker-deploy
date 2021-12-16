import { Router, Request, Response, NextFunction } from "express";

const router = Router();

router.get(
  "/hello/:name",
  (req: Request, res: Response, next: NextFunction) => {
    const { name } = req.params;
    res.send(`Hello ${name} from express !!! It is updated! Wheeee!`);
  }
);

export const exampleRouter = router;
