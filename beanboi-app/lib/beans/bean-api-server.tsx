import { apiFetchServer } from "../api-server";
import { Bean } from "./types/bean";

export async function getBeans(): Promise<Bean[]> {
  return apiFetchServer<Bean[]>("/beans", {
    method: "GET",
  });
}

export async function getBean(beanId: string): Promise<Bean> {
  return apiFetchServer<Bean>(`/beans/${beanId}`, {
    method: "GET",
  });
}
