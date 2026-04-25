import { apiFetch } from "../api";
import { Bean } from "./types/bean";


export async function getBeans(): Promise<Bean[]> {
  if (debug) {
    return exampleBeans;
  }
  return apiFetch<Bean[]>("/beans", {
    method: "GET",
  });
}

export async function getBean(beanId: string): Promise<Bean> {
  return apiFetch<Bean>(`/beans/${beanId}`, {
    method: "GET",
  });
}

export async function createBean(bean: Bean): Promise<string> {
  return apiFetch<string>("/users/beans/", {
    method: "POST",
    bodyJson: bean,
  });
}

export async function updateBean(beanId: string, bean: Bean): Promise<void> {
  return apiFetch<void>(`/users/beans/${beanId}`, {
    method: "POST",
    bodyJson: bean,
  });
}

export async function deleteBean(beanId: string): Promise<void> {
  return apiFetch<void>(`/users/beans/${beanId}`, {
    method: "DELETE",
  });
}


const exampleBeans: Bean[] = [
  {
    id: "123",
    name: "TestBean",
    roaser: "Faro",
    process: "Black Honey",
    origin: "Your mom",
    roastLevel: 2,
    altitude: 1000,
    price: 0,
    timesPurchased: 0,
    uid: "",
    isActive: true,
  },
  {
    id: "456",
    name: "Tanzania peaberry",
    roaser: "Faro",
    process: "Washed",
    origin: "Tanzania",
    roastLevel: 1,
    altitude: 1001,
    price: 0,
    timesPurchased: 2,
    uid: "",
    isActive: true,
  },
]

export const debug = true;
