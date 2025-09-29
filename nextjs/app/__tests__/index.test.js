import { render, screen } from '@testing-library/react'
import HomePage from '../pages/index'

describe('HomePage', () => {
  it('should return Hello, Docker!', () => {
    render(<HomePage />)

    const heading = screen.getByRole('heading', { level: 1 })
    expect(heading).toHaveTextContent('Hello, Docker!')
  })
})