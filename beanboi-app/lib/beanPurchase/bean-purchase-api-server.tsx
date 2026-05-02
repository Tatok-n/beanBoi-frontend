import { apiFetchServer } from "../api-server";
import { BeanPurchase } from "./types/beanPurchase";

export async function getBeanPurchases(): Promise<BeanPurchase[]> {
  return apiFetchServer<BeanPurchase[]>("/bean-purchases", {
    method: "GET",
  });
}
